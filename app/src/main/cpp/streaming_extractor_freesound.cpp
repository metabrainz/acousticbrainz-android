/*
 * Copyright (C) 2006-2020  Music Technology Group - Universitat Pompeu Fabra
 *
 * This file is part of Essentia
 *
 * Essentia is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License as published by the Free
 * Software Foundation (FSF), either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the Affero GNU General Public License
 * version 3 along with this program.  If not, see http://www.gnu.org/licenses/
 */

#include <essentia/essentia.h>
#include <essentia/algorithm.h>
#include <essentia/algorithmfactory.h> 
#include <essentia/utils/extractor_freesound/extractor_version.h>
#include "extractor_utils.h"

using namespace std;
using namespace essentia;
using namespace essentia::standard;

// this code pretty much doubles streaming_extractor_music
int essentiaStreamingFreesound(string audioFilename, string outputFilename, string profileFilename) {
  // Returns: 1 on essentia error

  try {
    essentia::init();

    cout.precision(10); // TODO ????

    Pool options;
    setExtractorDefaultOptions(options);
    setExtractorOptions(profileFilename, options);

    Algorithm* extractor = AlgorithmFactory::create("FreesoundExtractor",
                                                    "profile", profileFilename);

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
    cerr << e.what() << endl;
    return 1;
  }
  catch (const std::bad_alloc& e) {
    cerr << "bad_alloc exception: Out of memory " << e.what() << endl;
    return 1;
  }

  return 0;
}
