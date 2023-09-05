package com.example.acarreo_app.ACARREO_FILE

import android.annotation.SuppressLint
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.appcompat.widget.AppCompatButton
import androidx.appcompat.widget.AppCompatEditText
import androidx.appcompat.widget.AppCompatSpinner
import androidx.core.view.isInvisible
import androidx.core.view.isVisible
import android.view.View
import android.widget.AdapterView
import androidx.appcompat.widget.AppCompatTextView
import com.example.acarreo_app.R

class SecondActivity : AppCompatActivity() {
    @SuppressLint("WrongViewCast")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_second)

        val nextButton = findViewById<AppCompatButton>(R.id.nextButton)
        val locationSpinner = findViewById<AppCompatSpinner>(R.id.locationSpinner)
        val descriptionInput = findViewById<AppCompatEditText>(R.id.descriptionInput)
        val descriptionLabel = findViewById<AppCompatTextView>(R.id.locationDescriptionLabel)

        val selectedLocation = locationSpinner.selectedItem.toString()

        locationSpinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                val selectedLocation = locationSpinner.selectedItem.toString()
                descriptionInput.isVisible = selectedLocation == "OTRO"
                descriptionLabel.isVisible = selectedLocation == "OTRO"
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {
                // No se seleccionó ningún elemento
            }
        }

        nextButton.setOnClickListener{

            val pantalla3 = Intent(this, ThirdActivity::class.java)
            startActivity(pantalla3)
        }
    }
}