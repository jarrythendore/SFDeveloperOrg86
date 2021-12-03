public class CORE_DataLayer {

    public CORE_DAO cd {get; set;}
    public Set<String> objNamesSet {get; set;}

    public List<CORE_CONFDAOWrapper> cfgWrapperList {get; set;}

    public CORE_DataLayer() {
        objNamesSet = new Set<String>();   
    }

    public void loadData(){
        this.cfgWrapperList = CORE_UTIL.generateConfigDAOList(CORE_CONFDAO.getAllActiveCONFRcords());
        if(this.cfgWrapperList != null && this.cfgWrapperList.size() > 0){
            cd = new CORE_DAO(this.cfgWrapperList);
            cd.mdataInitialization();
            cd.recordsInitialization(null);
        }
        
    }

}