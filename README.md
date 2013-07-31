# php_node
## Cookbook for PHP sites

Кукбук для разворачивания over 90000 PHP-проектов минимальными усилиями

По умолчанию создаёт директорию `/u/apps` в которую будет складывать все проекты

Для каждого сайта создаётся отдельная папка соответственно аттрибуту `:name`

В ней создается еще три:
  * `public` - Document Root проекта
  * `private` - Папка для файлов которые не должны быть доступны извне
  * `log` - Логи (По умолчанию иенно там будет error и access логи nginx)

Для каждого проекта создается пользователь в базе данных, его именем будет значение аттрибута `:name`, пароль - `:mysql_password`. Так же создается база с именем формата `#{site[:name]}_main`.

Для каждого проекта создается конфиг nginx.

## Зависимости

Используются кукбуки opscode.

В формате [Berkshelf](http://berkshelf.com/) (`Berksfile`):
```
site :opscode

cookbook 'apt'
cookbook 'openssh'

cookbook 'mysql'
cookbook 'database'

cookbook 'xml'
cookbook 'zlib'
cookbook 'php'
cookbook 'php-fpm'
cookbook 'nginx', '~> 0.101.5'
```

## Аттрибуты
  * `:sites` - Массив проектов которые надо развернуть
    * `:name` - Наззвание проекта
    * `:domain` - Домен который будет прописан в конфиге nginx
    * `:mysql_password` - Пароль до MySQL

## Использование
```
run_list [
  "recipe[apt]",
  "recipe[nginx]",
  "recipe[mysql::server]",
  "recipe[database::mysql]",

  "recipe[php]",
  "recipe[php::module_mysql]",
  "recipe[php::module_curl]",
  "recipe[php::module_gd]",
  "recipe[php-fpm]",

  "recipe[php_node]",
  "recipe[php_node::sites]"
]

default_attributes(
  mysql: {
    server_root_password: "SECURE_PASSWORD",
    server_repl_password: "SECURE_PASSWORD",
    server_debian_password: "SECURE_PASSWORD"
  },
  sites: [
    {
      name: "my_project",
      domain: "www.my_project.home",
      mysql_password: "SECURE_PASSWORD"
    },
  ]
)
```

## Contribute

Кукбук имеет статус личной тулзы для облегчения жизни, используйте его на свой страх и риск, если что-то не работает, то пожалуйста исправьте и пришлите pull request.
