namespace java com.rbkmoney.mnp
namespace erlang mnp

enum Operator {
    mts
    beeline
    megafone
    tele2
    yota
}

exception BadPhoneFormat {}
exception OperatorNotFound {}

struct ResponseData {
    1: required Operator operator
}

/**
* Телефонный номер согласно (E.164 — рекомендация ITU-T)
* +79114363738
* cc = 7 - код страны(1-3 цифры)
* ctn = 9114363738 - 10-ти значный номер абонента
*/
struct PhoneNumber {
    1: required string ctn
}

service Mnp {
    /**
    * Получить оператора по номеру телефона
    * кидает:
    *  BadPhoneFormat, некорректный телефон
    *  OperatorNotFound, если оператор не определен
    */
    ResponseData Lookup (1: PhoneNumber phone) throws (
        1: BadPhoneFormat   ex1
        2: OperatorNotFound ex2
    )
}
