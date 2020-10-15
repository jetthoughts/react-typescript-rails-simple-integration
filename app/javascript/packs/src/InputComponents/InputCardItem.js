import React from 'react'
import Button from "@material-ui/core/Button";
import {Autorenew, Backspace, FileCopy, PlayArrow, Publish, SaveAlt} from "@material-ui/icons";
import green from "@material-ui/core/colors/green";

export default class InputCardItem extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div className="card">
                <div className="card-title">
                    <span className="float-left">
                        <Button variant="contained" color="primary" startIcon={<SaveAlt/>}>Save Input</Button> &nbsp;
                        <Button variant="contained" color="default" startIcon={<Publish/>}>Load Input</Button>&nbsp;
                        <Button variant="contained" color="primary" startIcon={<FileCopy/>}>Paste Input</Button>&nbsp;
                    </span>
                    <span className="float-right">
                        <Button variant="contained"
                                color="secondary"
                                startIcon={<Backspace/>}>Clear</Button>&nbsp;
                        <Button variant="contained" color="primary" startIcon={<Autorenew/>}>Load Examples</Button>&nbsp;
                        <Button variant="contained" startIcon={<PlayArrow style={{ color: green[500] }}/>}>Process</Button>&nbsp;
                    </span>
                </div>
                <hr className="solid"/>
                <div className="card-body">
                    {this.props.contentForm}
                </div>
            </div>
        )
    }
}
