const width = 800
const height = 500
const margin = {
    top: 10,
    bottom: 40,
    left: 50, 
    right: 10
}

const svg = d3.select("#chart").append("svg").attr("height", height).attr("width", width)
const elementGroup = svg.append("g").attr("transform", `translate(${margin.left}, ${margin.top})`)

const axisGroup = svg.append("g").attr("is", "axisGroup")
const xAxisGroup = axisGroup.append("g").attr("id", "xAxisGroup").attr("transform", `translate(${margin.left}, ${height - margin.bottom})`)
const yAxisGroup = axisGroup.append("g").attr("id", "yAxisGroup").attr("transform",`translate(${margin.left}, ${margin.top})`)

const y = d3.scaleBand().range([height - margin.top - margin.bottom, 0]).padding(0.1)
const x = d3.scaleLinear().range([0, width - margin.left - margin.right])

const xAxis = d3.axisBottom().scale(x)
const yAxis = d3.axisLeft().scale(y)


let data2

d3.csv("data.csv").then(data =>{
    data.map(d => {
        d.titles = +d.titles
    })

    data2 = data
   
    x.domain([0, d3.max(data2.map(datum => datum.titles))])
    y.domain(data2.map(d => d.country))

    xAxisGroup.call(xAxis)
    yAxisGroup.call(yAxis)


    let elements = elementGroup.selectAll("rect").data(data)

    elements.enter()
        .append("rect")
        .attr("x", 0)
        .attr("y", (d, i) => y(d.country))
        .attr("width", d => x(d.titles))
        .attr("height", y.bandwidth())
})

