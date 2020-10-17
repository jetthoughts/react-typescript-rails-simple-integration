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
    // this.state = {
    //   outputTextToCopy: this.props.content.output,
    //   errorText: undefined,
    //   btnText: "Copy to Clipboard",
    // };
    this.state = OutputCardItem.handleNewProps(props)

    this.handleInputChange = this.handleInputChange.bind(this);
    this.handleCopy = this.handleCopy.bind(this);
    // this.handleNewProps = this.handleNewProps.bind(this);
    // const newState = OutputCardItem.handleNewProps(props)

    this.editor = this.ace_module(props)
  }

  componentWillReceiveProps(nextProps) {
    const newState = OutputCardItem.handleNewProps(nextProps)
    if (newState && this.state && (nextProps.content.output !== this.state.outputTextToCopy)) {
      this.setState(newState)
    }
  }

  static handleNewProps(nextProps) {
    // if (nextProps.content.output !== this.props.content.output) { // bug?.. shouldn't we look at state?
    // if (this.state && (nextProps.content.output !== this.state.outputTextToCopy)) {
      const outputText = nextProps.content.output || ""
      const errorText = nextProps.content.error
      return ({
        errorText: errorText,
        outputTextToCopy: outputText,
        btnText: "Copy to Clipboard"
      })
    // }
  }

  handleInputChange(e) {
    console.log("OUPUT CHANGE TRIGGER")
    this.setState({
      outputTextToCopy: e.target.value,
      btnText: "Copy to Clipboard"
    });
  }

  handleCopy() {
    copy(this.state.outputTextToCopy);
    this.setState({btnText: "Copied!"}); // todo: return back to default text with few secs delay
  }

  ace_module(props) {
    return (height, text) => {
      return (<pre className="ace-holder">
                <AceEditor
                  height={height}
                  // width="820px"

                  // height={"inherit"}
                  width={"inherit"}

                  mode="yaml"
                  theme="xcode"
                  name="UNIQUE_ID_OF_DIV"
                  value={text}
                  editorProps={{$blockScrolling: true}}
                  setOptions={{
                    enableBasicAutocompletion: true,
                    enableLiveAutocompletion: true,
                    enableSnippets: true,
                    autoScrollEditorIntoView: true,
                  }}
                  // required={props.required}
                  // onChange={(value) => props.onChange(value)}
                  onChange={this.handleInputChange}
                />
              </pre>)
    }
  }

  render() {
    const {outputTextToCopy, btnText, errorText} = this.state;
    const errorAlert = !!errorText ?
      <div className="alert alert-danger" role="alert">
        {errorText}
      </div>
    : '';
    // console.log(`${outputTextToCopy} : ${errorText}`)
    return (
      <div className="card">
        <div className="card-title">
                    <span className="float-left">
                        <h4 className="code">OUTPUT:</h4>
                    </span>
          <span className="float-right">
                        <Button onClick={this.handleCopy} disabled={btnText === "Copied!"} variant="contained"
                                color="primary" startIcon={<FileCopy/>}>{btnText}</Button>
                    </span>
        </div>
        <hr className="solid"/>
        <div className="card-body">
          {/*<Input componentClass="textarea" rows={300} style={{ height:'auto', width: 900, resize: 'auto' }} value={outputTextToCopy} onChange={this.handleInputChange}*/}
          {/*/>*/}
          <div className="form-group">
            {/*<textarea rows={31} cols={99} className="codeWhite" value={outputTextToCopy} onChange={this.handleInputChange} />*/}

            {/*<span className="codeWhite" value={outputTextToCopy} onChange={this.handleInputChange} /><p>{outputTextToCopy}</p>*/}

            {/*<pre className="ace-holder">*/}
            {/*  <AceEditor*/}
            {/*    // height="200px"*/}
            {/*    // width="820px"*/}

            {/*    // height={"inherit"}*/}
            {/*    // width="inherit"*/}
            {/*    maxLines={Infinity}*/}
            {/*    height={"inherit"}*/}
            {/*    // width={"inherit"}*/}

            {/*    mode="yaml"*/}
            {/*    theme="xcode"*/}
            {/*    name="UNIQUE_ID_OF_DIV"*/}
            {/*    value={outputTextToCopy}*/}
            {/*    editorProps={{$blockScrolling: true}}*/}
            {/*    setOptions={{*/}
            {/*      enableBasicAutocompletion: true,*/}
            {/*      enableLiveAutocompletion: true,*/}
            {/*      enableSnippets: true,*/}
            {/*      autoScrollEditorIntoView: true*/}
            {/*    }}*/}
            {/*    // required={props.required}*/}
            {/*    onChange={this.handleInputChange}*/}
            {/*  />*/}
            {/*</pre>*/}
            {errorAlert}
            {this.editor("900px", outputTextToCopy)}
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
