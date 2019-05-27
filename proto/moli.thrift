namespace java com.rbkmoney.moli
namespace erlang moli

enum Operator {
    mts
    beeline
    megafone
    tele2
    yota
}

exception BadPhoneFormat {}
exception ProviderNotFound {}

struct ResponseData {
    1: required Operator operator
}

/**
* Телефонный номер согласно (E.164 — рекомендация ITU-T)
* +79114363738
* 7 - код страны(1-3 цифры)
* 9114363738 - 10-ти значный номер абонента(максимум 15)
*/
struct PhoneNumber {
    1: required string phone
}

service Moli {
    /**
    * Получить оператора по номеру телефона
    * кидает:
    *  BadPhoneFormat, некорректный телефон
    *  ProviderNotFound, если оператор не определен
    */
    ResponseData Lookup (1: PhoneNumber phone) throws (
        1: BadPhoneFormat   ex1
        2: ProviderNotFound ex2
    )
}
