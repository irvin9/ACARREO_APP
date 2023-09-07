package com.example.acarreo_app.ACARREO_FILE

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import androidx.appcompat.widget.AppCompatButton
import com.bumptech.glide.Glide
import com.example.acarreo_app.R

class ThirdActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_third)

        showGif()
        val module1Button = findViewById<AppCompatButton>(R.id.module1Button)
        module1Button.setOnClickListener{
            val scanScreen = Intent(this, nfcActivity::class.java)
            startActivity(scanScreen)
        }
    }
    fun showGif() {
        val imageView:ImageView = findViewById(R.id.nfcGif)
        Glide.with(this).load(R.drawable.nfc).into(imageView)
    }
}