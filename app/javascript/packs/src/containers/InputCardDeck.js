import React, {Component} from 'react'
import SchemaToForm from "../FormComponents/SchemaToForm";
import AppService from "../services/AppService";
import OutputCardItem from "../InputComponents/OutputCardItem";
import Button from "@material-ui/core/Button";
import {Autorenew, Backspace, FileCopy, PlayArrow, Publish, SaveAlt} from "@material-ui/icons";
import green from "@material-ui/core/colors/green";
import AceEditor from "react-ace";

export default class InputCardDeck extends Component {
    constructor(props) {
        super(props);
        this.AppService = AppService.instance;
        this.selectScript = this.selectScript.bind(this)
        this.state = {
            scriptId: '',
            script: {},
            scriptOutput:'',
            testScript: {
                id: 1,
                title: '1 - Wiki iGrapher',
                input: ''
            },
            formData:{},
            key: Date.now(),
            loadFormData:{
                sections: 'Load sections',
                depth: 2,
                layout: 'Load layout'

            },
            testSchema: {
                title: "Form Gen",
                type: "object",
                required: ["title"],
                properties: {
                    title: {type: "string", title: "Title", default: "A new task"},
                    done: {type: "boolean", title: "Done?", default: false}
                }
            },
            uiSchema : {
                templates: {
                    "ui:widget": (props) => {
                        return (
                            <AceEditor
                                mode="json"
                                theme="github"
                                name="UNIQUE_ID_OF_DIV"
                                value={props.value}
                                editorProps={{ $blockScrolling: true }}
                                setOptions={{
                                    enableBasicAutocompletion: true,
                                    enableLiveAutocompletion: true,
                                    enableSnippets: true
                                }}
                                required={props.required}
                                onChange={(value) => props.onChange(value)}
                            />
                        );
                    }
                }
            }
        }
        this.sendInput = this.sendInput.bind(this)
        this.updateData= this.updateData.bind(this)
        this.resetInput = this.resetInput.bind(this)
        this.loadInput = this.loadInput.bind(this)
    }

    componentDidMount() {
        this.selectScript(this.props.match.params.scriptId);
        this.getScriptById(this.props.match.params.scriptId);
    }

    selectScript(inputScriptId) {
        this.setState({scriptId:inputScriptId})
    }

    componentWillReceiveProps(newProps) {
        this.selectScript(newProps.match.params.scriptId);
        this.getScriptById(newProps.match.params.scriptId);
    }

    getScriptById(scriptId) {
        this.AppService.findScriptById(scriptId).then((script) => {
            console.log("Fetched Script: ", script)
            const scriptMod = {
                id: scriptId,
                title: scriptId,
                ...script.schema.input
            }
            this.setState({script: scriptMod})
        })
    }

    sendInput(key) {
        console.log("Key: ",key)
        console.log("Sent to server: ", this.state.formData)
        // this.AppService.sendInput(key, this.state.formData)
        //     .then(output=>{
        //         console.log("OUTPUT FROm SERVER: ",output)
        //         this.setState({scriptOutput:output})
        //     })
    }

    resetInput() {
        console.log("cancel click",this.state)
        this.setState({
            formData: {},
            key: Date.now()
        })
    }

    loadInput() {
        console.log("load click",this.state)
        this.setState({
            formData: this.state.loadFormData,
            key: Date.now()
        })
    }

    updateData = (target, value) => {
        this.setState({ [target]: value });
    };

    renderFormFromScript() {
        return (
          <div className="card">
              <div className="card-title">
                        <span className="float-left">
                            <Button variant="contained" color="primary" startIcon={<SaveAlt/>}>Save Input</Button> &nbsp;
                            <Button variant="contained" color="default" startIcon={<Publish/>}>Load Input</Button>&nbsp;
                            <Button variant="contained" color="primary" startIcon={<FileCopy/>}>Paste Input</Button>&nbsp;
                        </span>
                  <span className="float-right">
                            <Button onClick={this.resetInput}
                                    variant="contained"
                                    color="secondary"
                                    startIcon={<Backspace/>}>Clear</Button>&nbsp;
                      <Button onClick={this.loadInput} variant="contained" color="primary" startIcon={<Autorenew/>}>Load Examples</Button>&nbsp;
                      <Button onClick={() => this.sendInput(this.state.script.id)} variant="contained" startIcon={<PlayArrow style={{ color: green[500] }}/>}>Process</Button>&nbsp;
                  </span>
              </div>

              <hr className="solid"/>

              <div className="card-body">
                            <SchemaToForm schema={this.state.script} uiSchema={this.state.uiSchema} formData={this.state.formData} updateData={this.updateData} key={this.state.script.id}/>
                            {/*<SchemaToForm schema={this.state.script.schema.input} uiSchema={this.state.uiSchema} formData={this.state.formData} key={this.state.script.id}/>*/}
              </div>
          </div>
        )
    }

    render() {
        return (
            <div className="card-deck">
                {this.renderFormFromScript()}
                <OutputCardItem content={this.state.scriptOutput}/>
            </div>
        );
    }
}
