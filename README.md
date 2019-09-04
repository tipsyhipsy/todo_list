# README

Name
====
todo_list

## Model
**user**
　-id
　-name :string
　-email :string

**task**
　-id
　-user_id(FK)
　-label_id(FK)
　-name :string
　-description :text

**label**
　-id
　-task_id(FK)
　-name :string

Heroku
===
## Herokuへのデプロイ

**Herokuの準備**
```
$ heroku login (ログイン済の場合、省略可)
$ heroku create
```

**git commitコマンドを入力して、コミットをする。**
```
$ git add .
$ git commit -m "メッセージ"
```

**Herokuにpush**
```
$ git push origin master (heroku連携済の場合)
$ git push heroku master (heroku未連携の場合)
```

**データベースを移行する。**
```
$ heroku run rails db:migrate
```

---