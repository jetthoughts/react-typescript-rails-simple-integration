import React, {Component} from 'react'
import AceEditor from "react-ace";
import "ace-builds/src-noconflict/mode-javascript";
import "ace-builds/src-noconflict/theme-github";
import copy from "copy-to-clipboard";
import {FileCopy} from "@material-ui/icons";
import Button from "@material-ui/core/Button";

export default class OutputCardItem extends Component {

    constructor(props) {
        super(props);
        this.state = {
            textToCopy: this.props.content.output,
            btnText: "Copy to Clipboard"
        };
        this.handleInputChange = this.handleInputChange.bind(this);
        this.handleCopy = this.handleCopy.bind(this);
    }

    componentWillReceiveProps(nextProps){
        if (nextProps.content.output !== this.props.content.output) {
            this.setState({
                textToCopy: nextProps.content.output,
                btnText: "Copy to Clipboard"})

        }
    }

    handleInputChange(e) {
        console.log("OUPUT CHANGE TRIGGER")
        this.setState({
            textToCopy: e.target.value,
            btnText: "Copy to Clipboard"
        });
    }

    handleCopy() {
        copy(this.state.textToCopy);
        this.setState({ btnText: "Copied!" });
    }

    render() {
        const { textToCopy, btnText } = this.state;
        return (
            <div  className="card">
                <div className="card-title">
                    <span className="float-left">
                        <h4 className="code">OUTPUT:</h4>
                    </span>
                    <span className="float-right">
                        <Button onClick={this.handleCopy} disabled={btnText === "Copied!"} variant="contained" color="primary" startIcon={<FileCopy/>}>{btnText}</Button>
                    </span>
                </div>
                <hr className="solid"/>
                <div className="card-body">
                    {/*<Input componentClass="textarea" rows={300} style={{ height:'auto', width: 900, resize: 'auto' }} value={textToCopy} onChange={this.handleInputChange}*/}
                    {/*/>*/}
                    <div className="form-group">
                        <textarea rows={31} cols={99} className="codeWhite" value={textToCopy} onChange={this.handleInputChange} />
                    </div>
                </div>
            </div>
        );
        // return (
        //     <div className="card">
        //         <h5 className="card-title">Output</h5>
        //         <div className="card-body">
        //             <AceEditor
        //                 mode="javascript"
        //                 theme="github"
        //                 name="UNIQUE_ID_OF_DIV"
        //                 editorProps={{ $blockScrolling: true }}
        //                 setOptions={{
        //                     enableBasicAutocompletion: true,
        //                     enableLiveAutocompletion: true,
        //                     enableSnippets: true
        //                 }}
        //             />
        //         </div>
        //     </div>
        // )
    }


}
