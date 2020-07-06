package org.metabrainz.essentiaandroid;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

import org.metabrainz.essentiaandroid.EssentiaJava;

public class AudioAnalysisWorker extends Worker {
    public static final String INPUT_PATH =  "input";
    public static final String OUTPUT_PATH = "output";
    public AudioAnalysisWorker(@NonNull Context context, @NonNull WorkerParameters workerParams) {
        super(context, workerParams);
    }

    @NonNull
    @Override
    public Result doWork() {
        String inputPath = getInputData().getString(INPUT_PATH);
        String outputPath = getInputData().getString(OUTPUT_PATH);
        int result = EssentiaJava.essentiaMusicExtractor(inputPath, outputPath);
        if (result != 0)
            return Result.failure();
        return Result.success();
    }


}
