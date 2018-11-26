import QtQuick 2.9

Item {
    id: strings

    // Landing page
    readonly property string santas: qsTr("Santas")
    readonly property string around_the_world: qsTr("AROUND THE WORLD")
    readonly property string sign_in: qsTr("Sign In")

    // List page
    readonly property string turkey_santa_name: qsTr("Saint Nicholas")
    readonly property string turkey: qsTr("Turkey")
    readonly property string turkey_santa_description: qsTr("The story of Santa Claus can be traced back hundreds of years to 4th-century Greek Christian bishop Saint Nicholas who was born in Myra, Turkey.")
    readonly property string greece_santa_name: qsTr("Agios Vasilis")
    readonly property string greece: qsTr("Greece")
    readonly property string greece_santa_description: qsTr("Agios Vasilis (Αγιος Βασίλης), the Greek Santa, traditionally delivers presents on New Year’s Eve--the day before the feast day for St. Basil, a founder of the Greek Orthodox Church.")
    readonly property string uk_santa_name: qsTr("Father Christmas")
    readonly property string uk: qsTr("United Kingdom")
    readonly property string uk__santa_description: qsTr("Father Christmas traditionally flies over houses in England on an enchanted white horse, but if a white horse isn’t available, he may take a goat.")
    readonly property string netherlands_santa_name: qsTr("Sinterklaas")
    readonly property string netherlands: qsTr("Netherlands")
    readonly property string netherlands__santa_description: qsTr("Sinterklaas carries the big book that tells whether each child has been good or naughty in the past year. He traditionally rides a white horse.")
    readonly property string japan_santa_name: qsTr("Hoteiosho")
    readonly property string japan: qsTr("Japan")
    readonly property string japan__santa_description: qsTr("In Japan a traditional Buddhist monk named Hoteiosho carries a sack and bears gifts, but most children fear Hoteiosho and prefer the western Santa Claus tradition.")
}
