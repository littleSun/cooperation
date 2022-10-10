package com.gtbluesky.cooperation_example

import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.gtbluesky.cooperation.Cooperation
import com.gtbluesky.cooperation_example.databinding.ActivityMainBinding
import io.flutter.plugin.common.MethodChannel

class MainActivity: AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        binding.tv1.setOnClickListener {
            Cooperation.call("m1", mapOf("platform" to "Android"), object : MethodChannel.Result {
                override fun success(result: Any?) {
                    Toast.makeText(this@MainActivity, "success:$result", Toast.LENGTH_SHORT).show()
                }

                override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                    Toast.makeText(this@MainActivity, "error:$errorCode", Toast.LENGTH_SHORT).show()
                }

                override fun notImplemented() {
                    Toast.makeText(this@MainActivity, "notImplemented", Toast.LENGTH_SHORT).show()
                }
            })
        }
        binding.tv2.setOnClickListener {
            Cooperation.call("m2", result = object : MethodChannel.Result {
                override fun success(result: Any?) {
                    Toast.makeText(this@MainActivity, "success:$result", Toast.LENGTH_SHORT).show()
                }

                override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                    Toast.makeText(this@MainActivity, "error:$errorCode", Toast.LENGTH_SHORT).show()
                }

                override fun notImplemented() {
                    Toast.makeText(this@MainActivity, "notImplemented", Toast.LENGTH_SHORT).show()
                }
            })
        }
    }
}
