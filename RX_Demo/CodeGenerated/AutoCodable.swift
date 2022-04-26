// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import HandyJSON

extension CBPersonModel {
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<<
            name <-- "nameString"
    }
}
