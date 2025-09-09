package com.example.schuly

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "schuly/url_launcher"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "launchEmail" -> {
                    val email = call.argument<String>("email")
                    val subject = call.argument<String>("subject")
                    if (email != null) {
                        val launched = launchEmail(email, subject)
                        result.success(launched)
                    } else {
                        result.error("INVALID_ARGUMENT", "Email cannot be null", null)
                    }
                }
                "launchUrl" -> {
                    val url = call.argument<String>("url")
                    if (url != null) {
                        val launched = launchUrl(url)
                        result.success(launched)
                    } else {
                        result.error("INVALID_ARGUMENT", "URL cannot be null", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun launchEmail(email: String, subject: String?): Boolean {
        return try {
            val intent = Intent(Intent.ACTION_SENDTO).apply {
                data = Uri.parse("mailto:")
                putExtra(Intent.EXTRA_EMAIL, arrayOf(email))
                if (subject != null) {
                    putExtra(Intent.EXTRA_SUBJECT, subject)
                }
            }
            
            // Check if there's an email app available
            if (intent.resolveActivity(packageManager) != null) {
                startActivity(intent)
                true
            } else {
                // Fallback: try with mailto URL
                val mailtoUri = if (subject != null) {
                    "mailto:$email?subject=${Uri.encode(subject)}"
                } else {
                    "mailto:$email"
                }
                val fallbackIntent = Intent(Intent.ACTION_VIEW, Uri.parse(mailtoUri))
                startActivity(fallbackIntent)
                true
            }
        } catch (e: Exception) {
            false
        }
    }

    private fun launchUrl(url: String): Boolean {
        return try {
            val uri = Uri.parse(url)
            val intent = Intent(Intent.ACTION_VIEW, uri).apply {
                addCategory(Intent.CATEGORY_BROWSABLE)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            }
            startActivity(intent)
            true
        } catch (e: Exception) {
            false
        }
    }
}
