package com.example.helloworld;

public enum FormFieldId {
    NAME("name");

    private final String id;

    FormFieldId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }
}
