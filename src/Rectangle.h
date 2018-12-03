//
//  Rectangle.h
//  TogglDesktopLibrary
//
//  Created by Nghia Tran on 11/22/18.
//  Copyright © 2018 Toggl. All rights reserved.
//

#ifndef Rectangle_h
#define Rectangle_h

#include <string>
#include "Poco/Types.h"

namespace toggl {

class Rectangle {
    private:
        const Poco::UInt64 width;
        const Poco::UInt64 height;

    public:
        Rectangle(const Poco::UInt64 w, const Poco::UInt64 h): width(w), height(h) {}

        std::string str() const;
    };
}

#endif /* Rectangle_h */
