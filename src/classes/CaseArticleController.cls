public class CaseArticleController
{

    public String caseArticle { get; set; }

    public CaseArticleController() {

    }
    public CaseArticleController(ApexPages.StandardController ssc)
    {
    List<CaseArticle> caseArticle = [SELECT CaseId,Id,ArticleLanguage,ArticleVersionNumber,KnowledgeArticleId FROM CaseArticle WHERE CaseId =:ApexPages.currentPage().getParameters().get('id')];
    system.debug('List: '+caseArticle);
     }  
     
}