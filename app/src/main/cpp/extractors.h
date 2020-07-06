using namespace std;

void usage(char *progname);
int essentia_main(string audioFilename, string outputFilename, string profileName);
int essentiaMFCC(string audioFilename, string outputFilename);
int essentiaStreamingExtractor(string audioFilename, string outputFilename, string profileName);
int essentiaStreamingFreesound(string audioFilename, string outputFilename, string profileName);
int essentiaStreamingLaCapula(string audioFilename, string outputFilename);
int essentiaStreamingMFCC(string audioFilename, string outputFilename);
