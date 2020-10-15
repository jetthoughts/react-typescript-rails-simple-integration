import React, {Component} from 'react'
import Form from "@rjsf/core";
import AceEditor from "react-ace";
import "ace-builds/src-noconflict/mode-json";
import "ace-builds/src-noconflict/theme-github";
import AppService from "../services/AppService";

export default class SchemaToForm extends Component {
    constructor(props) {
        super(props);
        // this.AppService = AppService.instance;
    }

    render() {
        let self = this;
        return (
          <div className="container-fluid">
            <div className="card-body">
                    <Form schema={self.props.schema}
                          uiSchema={self.props.uiSchema}
                          formData={self.props.formData}
                          onChange={e => self.props.updateData('formData', e.formData)}
                          children={' '}
                    >
                    </Form>
            </div>
          </div>
        )
    }
}




