package com.example.acarreo_app.ACARREO_FILE
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.appcompat.widget.AppCompatButton
import com.example.acarreo_app.R
import kotlin.math.log

class FirstAppActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_first_app)
        val viajes = findViewById<AppCompatButton>(R.id.viajes)

        viajes.setOnClickListener{
            var pant:Int = 5
            Log.i("irving","se ah pulsado el boton $pant")

            if (pant == 5) {
                val pantalla2 = Intent(this, SecondActivity::class.java)
                startActivity(pantalla2)
            }

        }

    }
}
