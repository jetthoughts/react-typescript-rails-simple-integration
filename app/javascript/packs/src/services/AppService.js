let _singleton = Symbol();
const SCRIPT_API_URL = 'http://8413917c-a7ac-4ea3-b133-1e2714d25491.mock.pstmn.io/api/scripts';

class AppService {
    constructor(singletonToken) {
        if (_singleton !== singletonToken)
            throw new Error('Cannot instantiate directly.');
    }
    static get instance() {
        if(!this[_singleton])
            this[_singleton] = new AppService(_singleton);
        return this[_singleton]
    }

    findAllScripts() {
        return fetch(SCRIPT_API_URL)
            .then(function (response){
                return response.json()
            })
    }

    findScriptByName(scriptName) {
        return fetch(SCRIPT_API_URL + '/' + scriptName)
            .then(function(response){
                return response.json();
            });
    }

    findScriptById(scriptId) {
        return fetch(SCRIPT_API_URL + '/' + scriptId)
            .then(function(response){
                return response.json();
            });
    }

    sendInput(scriptId, formData) {
        return fetch(SCRIPT_API_URL + '/'+scriptId,{
            body: JSON.stringify(formData),
            headers: {
                'Content-Type': 'application/json'
            },
            method:'POST'
        }).then(function(response){
            console.log("App service server response: ", response)
            return response.json();
        })
    }

}
export default AppService;
