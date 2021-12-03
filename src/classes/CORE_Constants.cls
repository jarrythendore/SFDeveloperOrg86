/*************************************
 * @ all constant value for the feature
 * @ Created by Rui. Qian, Aug 25, 2021
 * 
 ****************************/
public class CORE_Constants {

    public static final Set<String> sObjectNameBlacklist =
    new Set<String>{ 
        'DandBCompany',
        'UserRole',
        'Profile',
        'CallCenter',
        'OperatingHours',
        'Pricebook2',
        'BusinessProcess',
        'UserLicense',
        'RecordType',
        'group'
    };

    //global object name config wrapper map
    public static final Map<String,CORE_CONFDAOWrapper> nameCfgWrapper = 
    new Map<String,CORE_CONFDAOWrapper>();


    public static String SELECT_CLAUSE = 'SELECT ';
    public static String WHERE_CLAUSE = ' WHERE ';
    public static String FROM_CLAUSE = ' FROM ';

	public static final String EQUALS = 'equals';
    /****
    * @description operator used for rendered condition
    */
    public static final String DOSE_NOT_EQUAL = 'does not equal';
    /****
    * @description operator used for rendered condition
    */
    public static final String CONTAINS = 'contains';
    /****
    * @description operator used for rendered condition
    */
    public static final String DOES_NOT_CONTAIN = 'does not contain';
    /****
    * @description operator used for rendered condition
    */
    public static final String STARTS_WITH = 'starts with';
    /****
    * @description operator used for rendered condition
    */
    public static final String ENDS_WITH = 'ends with';
    /****
    * @description operator used for rendered condition
    */
    public static final String INCLUDES = 'includes';
    /****
    * @description operator used for rendered condition
    */
    public static final String EXCLUDES = 'excludes';
    /****
    * @description operator used for rendered condition
    */
    public static final String LESS_THAN = 'less than';
    /****
    * @description operator used for rendered condition
    */
    public static final String GREATER_THAN = 'greater than';
    /****
    * @description operator used for rendered condition
    */
    public static final String LESS_OR_EQUAL = 'less or equal';
    /****
    * @description operator used for rendered condition
    */
    public static final String GREATER_OR_EQUAL = 'greater or equal';
    /****
    * @description operator used for rendered condition
    */
    public static final String WITHIN = 'within';
}