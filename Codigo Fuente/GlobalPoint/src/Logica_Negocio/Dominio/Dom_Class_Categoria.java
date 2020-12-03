package Logica_Negocio.Dominio;



import Logica_Negocio.Dominio.CPorNom.LogN_ClassAb_CrePorNom;




/**
 * Class Categoria
 */
public class Dom_Class_Categoria extends LogN_ClassAb_CrePorNom {
    //Atributos_________________________________________________________________
    private int mCat_Num;


    //Contstructor________________________________________________________________

    public Dom_Class_Categoria (String mNom, int mCat_Num){
      super(mNom, "Categoria");
      setCat_Num(mCat_Num);
    }

    public Dom_Class_Categoria (String mNom){
        super(mNom, "Categoria");
        setCat_Num(-1);
    }

    //Opraciones__________________________________________________________________



    public int getCat_Num() {
        return mCat_Num;
    }

    public void setCat_Num(int mCat_Num) {
        this.mCat_Num = mCat_Num;
    }







    public void NotCambio (Object arg){
        super.setChanged();
        super.notifyObservers(arg);
    }





    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;

        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Dom_Class_Categoria other = (Dom_Class_Categoria) obj;
        
        if (this.mCat_Num != other.mCat_Num && this.mCat_Num > 0) {
            return false;
        }

        if ((this.getNom() == null) ? (other.getNom()!= null) : !this.getNom().equals(other.getNom())) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 59 * hash + this.mCat_Num;
        hash = 59 * hash + (this.getNom() != null ? this.getNom().hashCode() : 0);
        return hash;
    }

    @Override
    public boolean setNom(String mNom) {
        mNom = mNom.trim();
        if (mNom.equals(""))return false;
        super.mNom = mNom; return true;
    }



    @Override
    public String[] getIgualInva(LogN_ClassAb_CrePorNom xObjCoparado) {
        throw new UnsupportedOperationException("Not supported yet.");
    }





    @Override
    public Dom_Class_Categoria duplicar() {
        return new Dom_Class_Categoria(mNom, mCat_Num);
    }


}
