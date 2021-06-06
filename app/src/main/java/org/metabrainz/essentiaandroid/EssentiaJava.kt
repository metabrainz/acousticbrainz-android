package org.metabrainz.essentiaandroid;

public class EssentiaJava {
    public native static int essentiaMusicExtractor(String inputPath, String outputPath);
    public native static int essentiaStandardMFCC(String inputPath, String outputPath);

}
