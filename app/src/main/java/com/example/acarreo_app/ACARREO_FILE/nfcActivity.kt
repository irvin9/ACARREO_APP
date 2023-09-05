package com.example.acarreo_app.ACARREO_FILE
import android.nfc.NfcAdapter
import android.nfc.NdefMessage
import android.nfc.NdefRecord
import android.nfc.Tag
import android.nfc.tech.Ndef
import android.nfc.tech.NdefFormatable
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.acarreo_app.R
import android.content.Intent
import android.app.PendingIntent

class nfcActivity : AppCompatActivity() {

    private var nfcAdapter: NfcAdapter? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_nfc)

        nfcAdapter = NfcAdapter.getDefaultAdapter(this)
        if (nfcAdapter == null) {
            Toast.makeText(this, "NFC no disponible en este dispositivo", Toast.LENGTH_SHORT).show()
            finish()
            return
        }
    }

    override fun onResume() {
        super.onResume()
        enableNfcForegroundDispatch()
    }

    override fun onPause() {
        super.onPause()
        disableNfcForegroundDispatch()
    }

    private fun enableNfcForegroundDispatch() {
//        nfcAdapter?.enableForegroundDispatch(this, PendingIntent, null, null)
    }

    private fun disableNfcForegroundDispatch() {
        nfcAdapter?.disableForegroundDispatch(this)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)

        if (intent.hasExtra(NfcAdapter.EXTRA_TAG)) {
            val tag: Tag? = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG)
            val ndef: Ndef? = Ndef.get(tag)

            ndef?.let {
                readNdefMessage(it)
            }
        }
    }

    private fun readNdefMessage(ndef: Ndef) {
        ndef.connect()

        val ndefMessage: NdefMessage? = ndef.ndefMessage
        ndefMessage?.let {
            val records: Array<NdefRecord> = it.records

            for (record in records) {
                val payload: ByteArray = record.payload
                val text: String = String(payload)
                Toast.makeText(this, "Texto encontrado: $text", Toast.LENGTH_SHORT).show()
            }
        }

        ndef.close()
    }
}