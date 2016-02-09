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

```
to create a class
  by an associate list of messages and methods
```

```scheme
(define <class-name>
  (CLASS
    (cons <message> <method>)
    (cons <message> <method>)
    ...))
```

---------------------

```
the shape of method is
```

```scheme
(lambda (this <message> <argument> ...)
  <body>)
```

---------------------

## object

```
to create an object by an associate list of messages and methods
this associate list of object
  is appended to the associate list of the class
```

```scheme
(<class>
  (cons <message> <method>)
  (cons <message> <method>)
  ...)
```

---------------------

```
right before the creation
  the massage `require is passed to the object
  which should returns a list of messages
  which must occur in the associate list of object
```

```
right after the creation
  the massage `init is passed to the object
```

---------------------

## message

```
message passing is like
```

```scheme
(<object> <message> <argument> ...)
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

```
to update a method with new value
```

```scheme
(<object> (up <message> <new-value>))
```

---------------------

## limit

can not inherit

how a poor kid ~

---------------------
