//
//  ImportForwards.h
//  Audacity
//
//  Created by Paul Licameli on 8/10/16.
//
//

#ifndef __AUDACITY_IMPORT_FORWARDS__
#define __AUDACITY_IMPORT_FORWARDS__

#include <vector>
#include "../MemoryX.h"

class ImportPlugin;
class UnusableImportPlugin;

using ImportPluginList =
   std::vector< movable_ptr<ImportPlugin> >;
using UnusableImportPluginList =
   std::vector< movable_ptr<UnusableImportPlugin> >;

#endif
