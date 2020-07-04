#include <essentia/essentia.h>
#include <essentia/algorithm.h>
#include <essentia/algorithmfactory.h>
#include <essentia/utils/extractor_music/extractor_version.h>
#include "extractor_utils.h"
#include "credit_libav.h"
#include <android/log.h>

using namespace std;
using namespace essentia;
using namespace essentia::standard;

void usage(char *progname) {
    cout << "Error: wrong number of arguments" << endl;
    cout << "Usage: " << progname << " input_audiofile output_textfile [profile]" << endl;
    cout << endl << "Music extractor version '" << MUSIC_EXTRACTOR_VERSION << "'" << endl
         << "built with Essentia version " << essentia::version_git_sha << endl;

    creditLibAV();
    exit(1);
}

int essentia_main(string audioFilename, string outputFilename) {
    // Returns: 1 on essentia error

    try {
        essentia::init();
        setDebugLevel(EExecution);

        cout.precision(10); // TODO ????

        Pool options;
        setExtractorDefaultOptions(options);
        setExtractorOptions("", options);

        Algorithm* extractor = AlgorithmFactory::create("MusicExtractor",
                                                        "profile", "");

        Pool results;
        Pool resultsFrames;

        extractor->input("filename").set(audioFilename);
        extractor->output("results").set(results);
        extractor->output("resultsFrames").set(resultsFrames);

        extractor->compute();

        mergeValues(results, options);

        outputToFile(results, outputFilename, options);
        if (options.value<Real>("outputFrames")) {
            outputToFile(resultsFrames, outputFilename+"_frames", options);
        }
        delete extractor;
        essentia::shutdown();
    }
    catch (EssentiaException& e) {
        __android_log_write(ANDROID_LOG_ERROR, "Essentia Android", e.what());
        return 1;
    }
    catch (const std::bad_alloc& e) {
        __android_log_write(ANDROID_LOG_ERROR, "Essentia Android", "bad_alloc exception: Out of memory");
        __android_log_write(ANDROID_LOG_ERROR, "Essentia Android", e.what());
        return 1;
    }

    return 0;
}
