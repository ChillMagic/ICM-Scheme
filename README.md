# ICM on Scheme

The Interpreter of The Chill Programming Language on Scheme

[ICM Project (using C++)](https://github.com/ChillMagic/ICM)

## How to use

This Project can be run on *Chez Scheme*.

### **At first, run compile-boot:**

**Windows:**

```
compile-boot.cmd
```

**Linux:**

```
bash ./compile-boot.sh
```

### **Then, select a mode to run:**

**REPL Mode :**

```
cd source
scheme --boot ../loadrelative.boot --script repl.ss
```

**File Mode :**

```
cd source
scheme --boot ../loadrelative.boot --script run.ss
```

**Create Library Document :**

```
cd source
scheme --boot ../loadrelative.boot --script do-library-analysis.ss
```
