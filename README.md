---------------------

# olin

in tokipona

olin means love

the etymon of which is 'volim' in Croatian

---------------------

this is object oriented programming implemented by one scheme function called 'CLASS'

class is function

object is function

message is symbol

---------------------

## class

to create class by associate list of message and method
```scheme
(define <class-name>
  (CLASS
    (cons <message> <method>)
    (cons <message> <method>)
    ...))
```

the shape of method is
```scheme
(lambda (this <message> <argument> ...)
  <body>)
```

---------------------

## object

to create object
```scheme
(<class>
  (cons <message> <method>)
  (cons <message> <method>)
  ...)
```

```
right after creation
  the massage `init is passed to the object
```

---------------------

## message

message passing is like
```scheme
(<class> <message> <argument> ...)
```

```
when passing a message to a object
  if the associated method is not a function
    it is returned
  if the associated method is a function
    it is called
    [note that object is function
     I have to put an object into a box to *not* call it]
```

---------------------

## limit

can not inherit

how a poor kid ~

---------------------
