# ![](https://github.com/DmitrJuga/InstaTest/blob/master/InstaTest/Images.xcassets/AppIcon.appiconset/mzl.wdhftovo-29@2x.png) InstaTest

**"InstaTest"** - пробное приложение на **Swift** с использованием **Instagram API**. Показывает фотографии пользователя в порядке убывания количества лайков.

![](https://github.com/DmitrJuga/InstaTest/blob/master/screenshots/screenshot1.png)
![](https://github.com/DmitrJuga/InstaTest/blob/master/screenshots/screenshot2.png)


## Функционал

- Логин и авторизация пользователя в Instagram.
- Отображение последних 20 фотографий пользователя в порядке убывания количества лайков.
- Отображение дополнительной информации по фотографиям: геотег, дата публикации, количество хэштегов, комментариев, отмеченных людей.
- Есть возможность разлогиниться - кнопка `X`, то при повторном входе логин не требуется. 

## Технические детали

- Работа с сетью штатными средствами (`NSURLSession`), без использования внешних библиотек.
- Работа с JSON штатными средствами (`NSJSONSerialization`), без использования внешних библиотек.
- Загрузка и кэширование изображений с помощью собственного класса `ImageCacheManager` (основан на [решении Ексея Пантелеева](https://github.com/Exey/moss-swift/blob/master/exey/moss/managers/ImageManager.swift), но без Alamofire).
- Аутентификация в Instagram по OAuth 2.0 протоколу с получением *access_token*.
- Окно логина вызывается модально и отображает форму авторизации в `UIWebView`.
- Для получения данных вызывается метод `users/self/media/recent` Instagram API.
- Использование `UIActivityIndicatorView` для индикации процесса загрузки данных и фото.
- UI построен в StoryBoard c использованием констрейнтов AutoLayout.
- AppIcon (изображение из свободных web-источников).

---

### Contacts

**Дмитрий Долотенко / Dmitry Dolotenko**

Krasnodar, Russia   
Phone: +7 (918) 464-02-63   
E-mail: <dmitrjuga@gmail.com>   
Skype: d2imas

:]

