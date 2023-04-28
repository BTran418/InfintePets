package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Breed;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(AnimalType.class)
public class AnimalType_ { 

    public static volatile SingularAttribute<AnimalType, String> animalType;
    public static volatile ListAttribute<AnimalType, Breed> breedList;
    public static volatile SingularAttribute<AnimalType, Integer> animalTypeID;

}