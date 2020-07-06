package org.metabrainz.acousticbrainz;

public final class AcousticBrainzClient {
    static {
        System.loadLibrary("acousticbrainz");
    }
    public native static int extractData(String inputPath, String outputPath);
}
