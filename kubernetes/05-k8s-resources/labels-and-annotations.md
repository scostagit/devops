# Labels and Annotations

Mark the object to be found by selectors.

Exemplo:

```yaml

selector:
    matchLabels:
      app: simulador-do-caos
    annotations:
      aplicacao: valor # it is not used by selectors.

```



### Attaching metadata to objects
You can use either labels or annotations to attach metadata to Kubernetes objects. Labels can be used to select objects and to find collections of objects that satisfy certain conditions. In contrast, annotations are not used to identify and select objects. The metadata in an annotation can be small or large, structured or unstructured, and can include characters not permitted by labels. It is possible to use labels as well as annotations in the metadata of the same object.

Annotations, like labels, are key/value maps:

```
"metadata": {
  "annotations": {
    "key1" : "value1",
    "key2" : "value2"
  }
}

```

### Documentation Best Pratices

[Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/)

[Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/)