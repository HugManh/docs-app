module.exports = function (eleventyConfig) {
    return {
        dir: {
            input: "content", // Thư mục chứa Markdown
            output: ".dist" // Thư mục chứa HTML
        }
    };
};
