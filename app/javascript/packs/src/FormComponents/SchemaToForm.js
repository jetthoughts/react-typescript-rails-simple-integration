import React, {Component} from 'react'
import Form from "@rjsf/core";
import AceEditor from "react-ace";
import "ace-builds/src-noconflict/mode-json";
import "ace-builds/src-noconflict/theme-github";
import AppService from "../services/AppService";

export default class SchemaToForm extends Component {
    constructor(props) {
        super(props);
        this.AppService = AppService.instance;
        this.state= {
            formData:{},
            key: Date.now(),
            loadFormData:{
                title: 'Load title',
                done: true
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
                title: {
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
        this.trackChange = this.trackChange.bind(this)
        this.resetInput = this.resetInput.bind(this)
        this.loadInput = this.loadInput.bind(this)
        // this.getUISchema = this.getUISchema.bind(this)
    }

    trackChange(event){
        // console.log("SchemaToForm Props: ", this.props.schema)
        this.setState({
            formData:event.formData
        })
        console.log("SchemaToForm: ", this.state.formData)
        // console.log("SchemaToForm: ", this.props.key)
        // this.AppService.sendInput(this.props.key, event.formData)
    }

    sendInput(key) {
        console.log("Key: ",key)
        console.log("Sent to server: ", this.state.formData)
        this.AppService.sendInput(key, this.state.formData)
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



    render() {
        let self = this;
        return(
            <div className="container-fluid">
                <Form schema={self.props.schema}
                      uiSchema={self.props.uiSchema}
                      formData={self.props.formData}
                      onChange={this.trackChange}
                      // onChange={this.sendInput()}
                      // onSubmit={(data)=>console.log(data.formData)}
                      // onError={this.sendInput.bind(this)}
                      children={' '}
                >
                    {/*<div>*/}
                    {/*    <button type="submit">Submit</button>*/}
                    {/*    <button type="button">Cancel</button>*/}
                    {/*</div>*/}
                    {/*<button type="submit" className="btn btn-primary">Process</button>*/}
                </Form>
                {/*<button type="submit" className="btn btn-primary" onClick={() => this.sendInput(this.props.schema.id)}>Process</button>*/}
                {/*/!*<button type="button" className="btn btn-success">Load Example</button>*!/*/}
                {/*<button type="button" className="btn btn-danger" onClick={self.resetInput}>Reset</button>*/}
                {/*<button type="button" className="btn btn-success" onClick={self.loadInput}>Load</button>*/}
            </div>

        )
    }
}
