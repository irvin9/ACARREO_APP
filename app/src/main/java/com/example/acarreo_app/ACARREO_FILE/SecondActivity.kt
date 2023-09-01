package com.example.acarreo_app.ACARREO_FILE

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.appcompat.widget.AppCompatButton
import com.example.acarreo_app.R

class SecondActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_second)

        val nextButton = findViewById<AppCompatButton>(R.id.nextButton)

        nextButton.setOnClickListener{
            val pantalla3 = Intent(this, ThirdActivity::class.java)
            startActivity(pantalla3)
        }
    }
}