package org.metabrainz.essentiaandroid;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;

import android.provider.OpenableColumns;
import android.util.Log;
import android.widget.TextView;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Objects;
import java.util.concurrent.Callable;

import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.core.Observable;
import io.reactivex.rxjava3.core.Scheduler;
import io.reactivex.rxjava3.schedulers.Schedulers;

public class MainActivity extends AppCompatActivity {

    private long begin;
    private static final int REQUEST_CODE = 5;
    static {
        try {
            System.loadLibrary("native-lib");
        } catch (Exception e ){
            e.printStackTrace();
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Example of a call to a native method
        TextView tv = findViewById(R.id.sample_text);
        tv.setText(stringFromJNI());

        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("audio/*");
        startActivityForResult(intent, REQUEST_CODE);
    }

    /**
     * A native method that is implemented by the 'native-lib' native library,
     * which is packaged with this application.
     */
    public native String stringFromJNI();
    public native int essentiaMusicExtractor(String inputPath, String outputPath);

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        if (requestCode == REQUEST_CODE) {
            try {
                InputStream inputStream = getContentResolver().openInputStream(data.getData());
                File tempFile = new File(getExternalCacheDir(), getFileName(data.getData()));

                byte[] buffer = new byte[inputStream.available()];
                inputStream.read(buffer);
                inputStream.close();

                OutputStream outputStream = new FileOutputStream(tempFile);
                outputStream.write(buffer);
                outputStream.close();

                File directory = getExternalFilesDir(null);
                String inputPath = tempFile.getAbsolutePath();
                if (!inputPath.endsWith(".mp3"))
                    inputPath = inputPath + ".mp3";
                String outputPath = directory.getAbsolutePath() + "/temp.json";
                Log.d("Essentia Android", "Input Path: " + inputPath);
                Log.d("Essentia Android", "Output Path: " + outputPath);

                String finalInputPath = inputPath;
                begin = System.currentTimeMillis();
                Observable
                        .fromCallable(() -> essentiaMusicExtractor(finalInputPath, outputPath))
                        .subscribeOn(Schedulers.newThread())
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe(this::essentiaTaskCompleted);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        super.onActivityResult(requestCode, resultCode, data);
    }

    private void essentiaTaskCompleted(int result) {
        long time = System.currentTimeMillis() - begin;
        time = time / (1000 * 60);
        Log.d("Essentia Android", "Result Code: " + result);
        ((TextView) findViewById(R.id.sample_text)).setText("Essentia Task Completed in " + time + " mins");
    }

    String getFileName(Uri uri) {
        String result = null;
        if (Objects.requireNonNull(uri.getScheme()).equals("content")) {
            Cursor cursor = getContentResolver()
                    .query(uri, null, null, null, null);
            if (cursor != null && cursor.moveToFirst())
                result = cursor.getString(cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME));
        }

        if (result == null) {
            result = uri.getPath();
            int cut = result.lastIndexOf('/');
            if (cut != -1) {
                result = result.substring(cut + 1);
            }
        }
        return result;
    }
}