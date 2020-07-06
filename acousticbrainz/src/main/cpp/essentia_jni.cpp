#include <jni.h>
#include <string>
#include "extractors.h"

string convertJStringToString(JNIEnv *env, jstring str) {
    jboolean is_copy;
    const char *CString = env->GetStringUTFChars(str, &is_copy);
    return std::string(CString);
}

extern "C"
JNIEXPORT jint JNICALL
Java_org_metabrainz_acousticbrainz_AcousticBrainzClient_extractData(JNIEnv *env, jclass,
        jstring input_path, jstring output_path) {
    std::string input = convertJStringToString(env, input_path);
    std::string output = convertJStringToString(env, output_path);
    int returnCode = essentia_main(input, output, "");
    return returnCode;
}
