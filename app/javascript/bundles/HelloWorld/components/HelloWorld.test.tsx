import * as React from 'react'
import { render } from "@testing-library/react";
import HelloWorld from './HelloWorld';

describe("App Component", function () {
  it("should have hello world message", function () {
    let { getByText } = render(<HelloWorld name='whatever'/>);
    expect(getByText("Hello world React!")).toMatchInlineSnapshot(`
      <h1>
        Hello world React!
      </h1>
    `);
  });
});