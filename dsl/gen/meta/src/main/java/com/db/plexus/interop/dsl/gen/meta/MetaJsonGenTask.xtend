/**
 * Copyright 2017 Plexus Interop Deutsche Bank AG
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.db.plexus.interop.dsl.gen.meta

import com.db.plexus.interop.dsl.gen.PlexusGenConfig
import java.io.IOException
import com.google.inject.Inject
import com.db.plexus.interop.dsl.gen.util.FileUtils
import java.io.File
import com.db.plexus.interop.dsl.gen.BaseGenTask
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.common.util.EList
import java.util.ArrayList

class MetaJsonGenTask extends BaseGenTask {

    @Inject
    MetaJsonGenerator generator

    override doGenWithResources(PlexusGenConfig config, EList<Resource> resources) throws IOException {
        val str = generator.generate(config, resources.filter[r | !r.URI.toString().endsWith("/google/protobuf/descriptor.proto")].toList)
        FileUtils.writeStringToFile(new File(config.outDir + "/interop.json"), str)
    }

    override inputFilesGlob(PlexusGenConfig config) {
        "*.interop"
    }

}