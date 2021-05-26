# 4bill-ios-sdk

### Введение
4bill.io это многоканальная платежная платформа, которая объединяет плательщиков, онлайн-торговцев, поставщиков услуг, эквайеров, банки и платежные системы.

### SDK
### Зависимости
Для комфортной работы сдк использует следующие зависимости:
```ruby
Alamofire
Marshal
Promises
QuickLayout
```
### Установка
SDK pay-api-ios-sdk может быть установлено через Cocoapods. В Podfile укажите следующее:
```ruby
pod 'PayApiIosSDK', :git => 'https://github.com/4bill/4bill-ios-sdk.git'
```
### Начало работы
Перед началом работы с pay-api-ios-sdk следует передать следующие параметры (выдаются компанией [4bill](https://docs.4bill.io/) ): 

* account_id
* wallet_id
* point_id
* api_token
```swift
PaymentSDK.shared.configure(accountID: 1111, walletID: 1111, pointID: 1111, authToken: "api_token", naviagation: navController)
```
Параметр naviagation в последующем можно изменить.
### Конфигурация работы SDK
* `shouldShowOTPEnterForm` переменная отвечающая за показ формы ввода кода подтверждения OTP. true - окно ввода показывается автоматически самим SDK, false - вызовется метод делегата SDK, оповещающий, что следует показать форму ввода кода, после чего вызвать метод обновления транзакции SDK, передать введенный код и ожидать вызова методов делегата SDK, оповещающих о результате проведения транзакции.
* `shouldShowLookUpEnterForm` переменная отвечающая за показ формы ввода кода подтверждения LookUp. true - окно ввода показывается автоматически самим SDK, false - вызовется метод делегата SDK, оповещающий, что следует показать форму ввода кода, после чего вызвать метод обновления транзакции SDK, передать введенный код и ожидать вызова методов делегата SDK, оповещающих о результате проведения транзакции.
* `termUrl` переменная для ввода TermURL. Является обязательной для проведения услуги host-2-host
* `returnUrl`  переменная для ввода returnURL. Клиент будет возвращен обратно к мерчанту на полученный при создании транзакции returnURL.
* `callBackUrl` переменная для ввода callbackURL. Клиент получит коллбэк на указанный при создании транзакции callbackURL.
* `successUrl` переменная для ввода successURL. Клиент будет возвращен на полученный при создании транзакции successURL.
* `failureUrl` переменная для ввода failureURL. Клиент будет возвращен на полученный при создании транзакции failureURL.
* `delegate` (PaymentSDKDelegate) является базовым делегатом для работы с SDK.
* `hostToHostDelegate` (HostToHostServiceDelegate) является делегатом для работы с услугой host-2-host, для получения всей информации о проведении транзакции данный делегат должен быть установлен вместе с делегатом PaymentSDKDelegate
* `locale` переменная отвечающая за передаваемое значение “locale” платежному шлюзу 4bill. Возможные значения ua, en, ru. По дефолту указано ua.
* `logo` переменная отвечающая за логотип компании клиента, используется для оплаты host-2-host при использовании готового решения UI.
* `shouldShowWebPageForTokenizationService` переменная отвечающая за показ контроллера с ссылкой pay_Url для продолжения услуги токенизации карты. true - SDK автоматически откроет контроллер с ссылкой, false - методу делегата будет передан ответ от сервера, содержащий данную ссылку. Метод делегата с ответом от сервера будет вызываться в независимости от значения данной переменной.
* `shouldShowWebPageForCardToCardService` переменная отвечающая за показ контроллера с ссылкой pay_Url для продолжения услуги перевода с карты на карту (платежная страница). true - SDK автоматически откроет контроллер с ссылкой, false - методу делегата будет передан ответ от сервера, содержащий данную ссылку. Метод делегата с ответом от сервера будет вызываться в независимости от значения данной переменной.
* `shouldShowWebPageForPaymentPageService` переменная отвечающая за показ контроллера с ссылкой pay_Url для продолжения услуги приема платежей (платежная страница). true - SDK автоматически откроет контроллер с ссылкой, false - методу делегата будет передан ответ от сервера, содержащий данную ссылку. Метод делегата с ответом от сервера будет вызываться в независимости от значения данной переменной.
* `navigation` переменная отвечающая за текущий UINavigationController, используется SDK для автоматического показа форм ввода кода подтверждения, контроллера оплат host-2-host, контроллера вебвью.

Для изменения значения любой переменной следует использовать синтаксис
```swift
PaymentSDK.shared.<имя переменной>
```
### PaymentSDKDelegate
При успешной операции создания транзакции будет вызван метод делегата 
```swift
func paymentSDKDidCreateTransaction(with response: CreateTransactionResponseData)
```
При успешной операции поиска транзакции будет вызван метод 
```swift
func paymentSDKDidFindTransaction(with response: FindTransactionResponseData)
```
При успешной операции отмены транзакции будет вызван метод 
```swift
func paymentSDKDidCancelTransaction(with response: CancelTransactionResponseData)
```
При надобности показа формы ввода кода подтверждения будет вызван метод. Данный метод является опциональным для реализации, вызывается в случае, если флаг shouldShowLookUpEnterForm или shouldShowOTPEnterForm отмечены как false при проведении услуги host-2-host.
```swift
func paymentSDKNeedCodeToProceedHostToHost(transactionID: Int, codeType: VerificationCode)
```
При любой ошибке проведения операций SDK будет вызван метод 
```swift
func paymentSDKDidFail(with error: Error, request: RequestType)
```
### HostToHostServiceDelegate
При финальном статусе транзакции, либо при авторизации типа “NONE” будет вызван метод
```swift
func paymentSDKDidFinihHostToHost(with response: PayTransactionResponseData)
```

После успешного проведения авторизации транзакции будет вызван метод
```swift
func paymentSDKDidFinihHostToHost(with response: UpdateTransactionResponseData)
```
### Прием платежей [(платежная страница)](https://docs.4bill.io/services/acquiring_form)
Проведение услуги приема платежа может осуществляться двумя методами: с токенизированой картой и без таковой. Для первого случая используется метод SDK: 
```swift
func createPaymentPage(cardToken: String, externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, extra: JSONObject?)
```
Для приема оплат без токенизированой карты используется метод SDK:
```swift
func createPaymentPage(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, extra: JSONObject?, shouldTokenizeCard: Bool)
```
* `cardToken` - ранее полученный токен платежной карты; 
* `externalTransactionId` - Идентификатор транзакции в системе мерчанта. Должен быть уникальным для каждой транзакции. Если в базе уже существует транзакция, создание платежа будет отклонено с ошибкой;
* `externalOrderId` - Идентификатор заказа в системе мерчанта. Допустимо создание нескольких транзакций с одинаковым id;
* `externalCustomerId` - Идентификатор клиента в системе мерчанта. Параметр необязательный, но крайне рекомендуется к использованию для улучшения поиска транзакций при разборе инцидентов, а также для более корректной работы антифрод-системы;
* `amount` - сумма транзакции в минимальных единицах (копейки)
* `amountCurrency` - Валюта платежа (3х-буквенный код ISO 4217). Например: UAH, USD, EUR, RUB;
* `serviceID` - идентификатор услуги платежного шлюза. Предоставляется менеджером. Именно данный параметр отвечает за то, какого типа транзакция создается;
* `description` - описание назначения платежа, до 100 символов.
* `extra` -  Дополнительные атрибуты платежа. Не влияют на проведение платежа, имеют информационных характер. 
* `shouldTokenizeCard` - параметр отвечающий за потребность токенизирования карты. При успешной операции токен карты будет присутствовать в поле ‘fields’ по ключу ‘card_token’.  

#### Синтаксис вызова данных методов
```swift 
PaymentSDK.shared.<имя метода>
```

### Прием платежей [(host-2-host)](https://docs.4bill.io/services/acquiring_h2h)
Для проведения услуги приема платежей host-2-host в SDK есть два варианта реализации: вызов метода проведения данной услуги либо вызов метода, который предоставляет уже готовый UI для ввода данных платежной карты с последующим проведением данной услуги.
При первом варианте используется синтаксис:
```swift
func hostToHost(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, fields: HostToHostFields)
```
* `externalTransactionId` - Идентификатор транзакции в системе мерчанта. Должен быть уникальным для каждой транзакции. Если в базе уже существует транзакция, создание платежа будет отклонено с ошибкой;
* `externalOrderId` - Идентификатор заказа в системе мерчанта. Допустимо создание нескольких транзакций с одинаковым id;
* `externalCustomerId` - Идентификатор клиента в системе мерчанта. Параметр необязательный, но крайне рекомендуется к использованию для улучшения поиска транзакций при разборе инцидентов, а также для более корректной работы антифрод-системы;
* `amount` - сумма транзакции в минимальных единицах (копейки)
* `amountCurrency` - Валюта платежа (3х-буквенный код ISO 4217). Например: UAH, USD, EUR, RUB;
* `serviceID` - идентификатор услуги платежного шлюза. Предоставляется менеджером. Именно данный параметр отвечает за то, какого типа транзакция создается;
* `description` - описание назначения платежа, до 100 символов.
* `fields` - структура содержащая данные платежной карты (номер, expiration month, expiration year, cvv код).

При втором варианте с предоставлением готового UI, используется метод SDK:
```swift
func presentPaymentController(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, controllerTitle: String?, style: UIModalPresentationStyle)
```
Передаваемые аргументы имеют тоже значение, что и указано выше, за исключением нескольких аргументов: 

* `controllerTitle` - значение, которое будет установлено как navigationTitle, по умолчанию имеет значение “Оплата”;
* `style` - то каким образом будет предоставлен контроллер ввода карты.  

При помощи метода `UINavigationController` present будет представлен контроллер  `BillioPayViewController`. После ввода данных карты и нажатию кнопки “Оплатить” будет проведена услуга host-2-host.

При использовании этих двух вариантов проведения услуги host-2-host следует ожидать подальшего вызова методов делегатов PaymentSDKDelegate либо HostToHostServiceDelegate (для коректной работы следует реализовать оба делегата). Проведение авторизации при данной услуги может настраиваться несколькими параметрами SDK (см. п. “Конфигурация работы SDK”). Для данной услуги можно изменить будут ли автоматически показываться формы ввода OTP, либо LookUp кода, если потребуется подобная авторизация при проведении данной услуги.
#### Особенности авторизации host-2-host 
##### None
При данном способе авторизации будет вызван метод делегата `HostToHostServiceDelegate` 
```swift
func paymentSDKDidFinihHostToHost(with response: PayTransactionResponseData)
```
##### 3Ds Secure
При данном способе авторизации SDK автоматически откроет WebView, где пользователь сможет пройти авторизацию после чего контроллер подтверждения будет автоматически закрыт и вызван метод делегата HostToHostServiceDelegate 
```swift
func paymentSDKDidFinihHostToHost(with response: PayTransactionResponseData)
```
ВАЖНО: для корректной работы SDK при данном способе авторизации перед началом работы обязательно следует предоставить TermUrl (см. п. “Конфигурация работы SDK”). 
##### LookUp 
При данном способе авторизации в зависимости от значения флага shouldShowLookUpEnterForm SDK либо само откроет форму ввода кода, после чего следует ожидать вызова метода делегата HostToHostServiceDelegate 
```swift
func paymentSDKDidFinihHostToHost(with response: PayTransactionResponseData) , либо будет вызван метод делегата PaymentSDKDelegate
func paymentSDKNeedCodeToProceedHostToHost(transactionID: Int, codeType: VerificationCode)
```
после чего вам следует предоставить ввод кода LookUp, вызвать метод SDK
```swift
func updateTransaction(transactionID: Int, code: String, codeType: VerificationCode)
```

и ожидать вызова метода делегата `HostToHostServiceDelegate`
```swift
func paymentSDKDidFinihHostToHost(with response: PayTransactionResponseData) 
```
##### OTP
При данном способе авторизации в зависимости от значения флага shouldShowOTPEnterForm SDK либо само откроет форму ввода кода, после чего следует ожидать вызова метода делегата HostToHostServiceDelegate 
```swift
func paymentSDKDidFinihHostToHost(with response: PayTransactionResponseData) , либо будет вызван метод делегата PaymentSDKDelegate
func paymentSDKNeedCodeToProceedHostToHost(transactionID: Int, codeType: VerificationCode)
```
после чего вам следует предоставить ввод кода OTP, вызвать метод SDK
```swift
func updateTransaction(transactionID: Int, code: String, codeType: VerificationCode)
```

и ожидать вызова метода делегата `HostToHostServiceDelegate`
```swift
func paymentSDKDidFinihHostToHost(with response: PayTransactionResponseData) 
```
##### Редирект
При данном методе авторизации SDK автоматически откроет WebView и после завершения авторизации будет вызван метод делегата PaymentSDKDelegate
```swift
func paymentSDKDidFindTransaction(with response: FindTransactionResponseData)
```

ВАЖНО: для корректной работы услуги host-2-host при авторизации данного типа следует предоставить returnUrl (см. п. “Конфигурация работы SDK”).
Неопределенный вариант
При данном типе авторизации SDK через каждые 5 секунд, но не более 2 минут будет производить поиск транзакции, после получения либо финального статуса, либо метода авторизации будут вызваны методы HostToHostServiceDelegate, либо PaymentSDKDelegate в зависимости от способа авторизации.
### Перевод с карты на карту [(платежная страница)](https://docs.4bill.io/services/p2p_transfer_form)
Для проведения услуги перевода с карты на карту используется метод SDK 
```swift
func p2pTransfer(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, recipientCardNumber: String, extra: JSONObject?)
```
При успешном создании транзакции будет вызван метод делегата `PaymentSDKDelegate`
```swift
func paymentSDKDidCreateTransaction(with response: CreateTransactionResponseData)
```
Далее в зависимости от значения флага `shouldShowWebPageForCardToCardService` SDK может само автоматически открыть экран WebView для продолжения проведения услуги.
### [Токенизация карты](https://docs.4bill.io/services/card_tokenization)
Для проведения услуги токенизации карты используется метод SDK 
```swift
func tokenizeCard(externalTransactionID: String, externalCustomerID: String?, serviceID: Int, description: String?)
```

При успешном создании транзакции будет вызван метод делегата PaymentSDKDelegate
```swift
func paymentSDKDidCreateTransaction(with response: CreateTransactionResponseData)
```

Далее в зависимости от значения флага `shouldShowWebPageForTokenizationService` SDK может само автоматически открыть экран WebView для продолжения проведения услуги.
### Дополнительно
В SDK также присутствуют методы для самостоятельного создания, обновления и посика транзакций
```swift
func createTransaction(externalTransactionID: String, externalOrderID: String?, externalCustomerID: String?, amount: Int, amountCurrency: String, serviceID: Int, description: String?, fields: JSONObject?, extra: JSONObject?, completion: @escaping(CreateTransactionResponseData) -> ())

func updateTransaction(transactionID: Int, auth: AuthorizationData, completion: @escaping(UpdateTransactionResponseData) -> ())

func findTransaction(transactionID: Int, externalTransactionID: String?, completion: @escaping(FindTransactionResponseData) -> ())
```
При возникновении ошибки данных методов будет вызван метод делегата PaymentSDKDelegate 
```swift
func paymentSDKDidFail(with error: Error, request: RequestType)
```
#### Синтаксис вызова функций
```swift
PaymentSDK.shared.<имя метода> 
```

