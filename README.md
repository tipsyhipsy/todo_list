# README

## model
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

