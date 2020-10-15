let _singleton = Symbol();
// const SCRIPT_API_URL = 'http://8413917c-a7ac-4ea3-b133-1e2714d25491.mock.pstmn.io/api/scripts';
// const PORT = 3000 // via rubymine
const PORT = 3175 // via shell puma
const SCRIPT_API_URL = `http://localhost:${PORT}/script`;

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
        return fetch(SCRIPT_API_URL+'.json')
            .then((response) => {
                // console.log(response)
                let json = response.json()
                // console.log(json)
                return json
            })
    }

    findScriptByName(scriptName) {
        return fetch(SCRIPT_API_URL + '/api/v1/' + scriptName+'.json')
            .then(function(response){
                return response.json();
            });
    }

    findScriptById(scriptId) {
        return fetch(SCRIPT_API_URL + '/api/v1/' + scriptId+'.json')
            .then(function(response){
                return response.json();
            });
    }

    sendInput(scriptId, formData) {
        return fetch(SCRIPT_API_URL + '/api/v1/'+scriptId+'.json',{
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
