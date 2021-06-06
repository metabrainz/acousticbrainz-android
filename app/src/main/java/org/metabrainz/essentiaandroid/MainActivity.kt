package org.metabrainz.essentiaandroid

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.provider.OpenableColumns
import android.util.Log
import android.view.View
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import java.io.File
import java.io.FileOutputStream
import java.io.OutputStream
import java.util.*

class MainActivity : AppCompatActivity() {
    private var begin: Long = 0
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT)
        intent.addCategory(Intent.CATEGORY_OPENABLE)
        intent.type = "audio/*"
        startActivityForResult(intent, REQUEST_CODE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE) {
            try {
                val fileName = getFileName(data!!.data)
                val tempFile = File(externalCacheDir, fileName)
                val directory = getExternalFilesDir(null)
                var inputPath = tempFile.absolutePath
                if (!inputPath.endsWith(".mp3")) inputPath = "$inputPath.mp3"
                val outputPath = directory!!.absolutePath + File.separator + fileName + ".json"
                Log.d("Essentia Android", "Input Path: $inputPath")
                Log.d("Essentia Android", "Output Path: $outputPath")

                val inputStream = contentResolver.openInputStream(data.data!!)
                val buffer = ByteArray(inputStream!!.available())
                inputStream.read(buffer)
                inputStream.close()
                val outputStream: OutputStream = FileOutputStream(tempFile)
                outputStream.write(buffer)
                outputStream.close()

                //essentiaMusicExtractor(finalInputPath, outputPath)

            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    private fun initiateWorkRequest() {
        begin = System.currentTimeMillis()
    }

    private fun essentiaTaskCompleted(result: Int) {
        var time = System.currentTimeMillis() - begin
        time /= (1000 * 60)
        Log.d("Essentia Android", "Result Code: $result")
        (findViewById<View>(R.id.sample_text) as TextView).text = "Essentia Task Completed in $time mins"
    }

    fun getFileName(uri: Uri?): String {
        var result: String? = null
        if (Objects.requireNonNull(uri!!.scheme) == "content") {
            val cursor = contentResolver.query(uri, null, null, null, null)
            if (cursor != null && cursor.moveToFirst()) result = cursor.getString(
                cursor.getColumnIndex(
                    OpenableColumns.DISPLAY_NAME
                )
            )
        }
        if (result == null) {
            result = uri.path
            val cut = result!!.lastIndexOf('/')
            if (cut != -1) {
                result = result.substring(cut + 1)
            }
        }
        return result
    }

    companion object {
        private const val REQUEST_CODE = 5
    }
}