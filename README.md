# flutter_rustore_miniapp_referrer

Плагин позволяет получить `referrerId` из приложения **RuStore**, если пользователь установил ваше приложение по реферальной (рекламной) ссылке.
То же самое можно сделать при отрытии вашего приложения напрямую на сайте. При этом поддерживаются параметры `utm_source` и `referrerId`. В RuStore только `referrerId`.

[Скачать](https://pub.dev/packages/flutter_rustore_miniapp_referrer)

---

## 📌 Описание

Если пользователь устанавливает приложение из RuStore по ссылке вида:

`https://www.rustore.ru/catalog/app/com.packagename.yourapp?referrerId=<referrer>`


то данный плагин позволяет получить значение параметра `referrerId` прямо внутри вашего Flutter-приложения от RuStore. Подробнее [здесь](https://www.rustore.ru/help/sdk/install-referrer/kotlin/10-0-0)


Это полезно для:
- трекинга рекламных кампаний
- реферальных систем
- аналитики установок

---

## ⚙️ Как это работает

- **Android**: плагин делает запрос к установленному RuStore через нативный SDK и получает `referrerId`, который сохраняется самим рустором, если пользователь пришел на ваше приложение по реферальной ссылке. RuStore удаляет `referrerId` сразу после запроса или через 10 дней, независимо от того был запрос или не. Но плагин сохраняет его и хранит в локальной базе, поэтому вы можете, без проблем, получить его и позже. Она сохраняет именно самое первое значение. Если потом значение поменяется, то плагин все равно будет хранить первое 



- **Web**: `referrerId` извлекается из URL (query-параметров)
так же на веб поддерживается параметр `utm_source`
То есть ссылка может быть вида:

`https://yoursite.ru?referrerId=SomeReferer123`

или

`https://yoursite.ru?utm_source=SomeReferer123`

--- 

## 🌍 Поддерживаемые платформы

- ✅ Android  
- ✅ Web  
- ❌ iOS пока не поддерживается

---

## 🚀 Использование

Просто виджет или Scaffold в котором вам нужно получить referrerId:

```dart

import 'package:flutter_rustore_miniapp_referrer/referrer_builder.dart';

/// оберните тот виджет, в котором вам нужно получить данные о referrerId
/// и если они доступны, то будут переданы в аргумент referrerData
ReferrerInfoBuilder(
  debug: false,
  builder: (ReferrerData? referrerData) {
    /// здесь будут данные
    return Center(child: Text('Ваш код'));
  },
);
``` 