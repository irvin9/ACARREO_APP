package com.example.acarreo_app.ACARREO_FILE

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.appcompat.widget.AppCompatButton
import com.example.acarreo_app.R

class ThirdActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_third)

        val module1Button = findViewById<AppCompatButton>(R.id.module1Button)

        module1Button.setOnClickListener{
            val scanScreen = Intent(this, ScanActivity::class.java)
            startActivity(scanScreen)
        }
    }
}