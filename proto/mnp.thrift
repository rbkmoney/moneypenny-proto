namespace java com.rbkmoney.mnp
namespace erlang mnp

enum Operator {
    mts
    beeline
    megafone
    tele2
    yota
}

typedef map<string, string> AdapterOptions

exception BadPhoneFormat {}
exception OperatorNotFound {}

struct ResponseData {
    1: required Operator operator
}

/**
* Телефонный номер согласно (E.164 — рекомендация ITU-T)
* +79114363738
* cc = 7 - код страны(1-3 цифры)
* ctn = 9114363738 - 10-ти значный номер абонента(макс 12)
*/
struct PhoneNumber {
    1: required string cc
    2: required string ctn
}

struct RequestParams {
    1: required PhoneNumber    phone
    2: optional AdapterOptions options = {}
}

service Mnp {
    /**
    * Получить оператора по номеру телефона
    * кидает:
    *  BadPhoneFormat, некорректный телефон
    *  OperatorNotFound, если оператор не определен
    */
    ResponseData Lookup (1: RequestParams params) throws (
        1: BadPhoneFormat   ex1
        2: OperatorNotFound ex2
    )
}
