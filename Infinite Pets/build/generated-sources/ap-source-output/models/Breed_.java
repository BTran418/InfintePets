package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.AnimalType;
import models.BreedPK;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Breed.class)
public class Breed_ { 

    public static volatile SingularAttribute<Breed, String> breedName;
    public static volatile SingularAttribute<Breed, BreedPK> breedPK;
    public static volatile SingularAttribute<Breed, AnimalType> animalType;

}