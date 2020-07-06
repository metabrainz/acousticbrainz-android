package org.metabrainz.acousticbrainz;

public final class AcousticBrainzClient {
    static {
        System.loadLibrary("acousticbrainz");
    }

    /**
     * Processes the input audio file using
     * <a href="https://essentia.upf.edu/streaming_extractor_music.html">Essentia's Streaming
     * Extractor Music</a> program and produces set of low-level and high-level data that can be
     * submitted to <a href="">AcousticBrainz</a>.
     * @param inputPath absolute path to audio file to be processed
     * @param outputPath absolute path to json file to which data should be written
     * @return 0 or 1 depending on whether process completes successfully or not
     */
    public native static int extractData(String inputPath, String outputPath);
}
