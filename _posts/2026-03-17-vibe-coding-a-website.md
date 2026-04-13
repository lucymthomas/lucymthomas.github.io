---
layout: post
title: welcome to my updated website! here's how I vibe-coded it
date: 2026-03-17 16:40:16
description: how I used claude and other tools to create my personal academic website
tags: ai academic-career
---

This website was built using [`Github.io`](https://docs.github.com/en/pages), [`Jekyll`](https://jekyllrb.com/), a template from [`al-folio`](https://github.com/alshedivat/al-folio), [`Docker`](https://www.docker.com/), a custom domain from [SquareSpace](https://www.squarespace.com/), and a lot of help from [`Claude`](https://claude.ai/new). Below I give more details about how I set it up, and my experience of using an AI agent for the first time as part of a software project.

---

Firstly, I started with the template from [`al-folio`](https://github.com/alshedivat/al-folio) which makes use of [`Jekyll`](https://jekyllrb.com/). I highly recommend anyone with any software experience to use this, the setup instructions in `QUICKSTART.md` and `INSTALL.md` are very clear and the template is highly customisable. 

<div class="row mt-3">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/al-folio.png" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    The template made it very easy to get started.
</div>

---

Once I had this set up, I was following the instructions inside `INSTALL.md` to use [`Docker`](https://www.docker.com/) for local development of the site before deployment. I ran into lots of hiccups with `Ruby` and `Gem` versions which I wasn't familiar with (I'm definitely not a web developer!) and so I turned to the in-built AI agent feature in `VSCode` to help. `Claude Sonnet 4.6` fix the issues almost immediately. I also got it to write some [documentation](https://github.com/lucymthomas/lucymthomas.github.io/blob/main/DOCKER_DEV.md) inside my `Github` repository explaining the steps and common pitfalls.

---

Next, it was time to start customising. Now that `Claude Sonnet 4.6` had demonstrated its power, I shamelessly used it for every tiny change and feature I wanted to implement. Here's an example:

<div class="row mt-3">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/claude-helps.png" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Claude helped me with a two-line change I probably could have done myself.
</div>

And after many many prompt iterations, the website was constructed.

I then finally published the site to a custom domain bought from [SquareSpace](https://www.squarespace.com/) using [these intructions]() from `Github`.

---

Based on my albeit limited experience of vibe-coding, here are four lessons learned:

> (1) LLMs are becoming very sophisticated at solving code problems, but you must be very specific about what you're asking the agent to do.

As an example, I gave the following prompt: "in light mode, the text which shows the date of the post isnt visible because its the same colour as the background, so can we change it to dark gray"

This left too much room for interpretation, and `Claude` changed the text colour to light gravy *universally*, not just in light mode.

Additionally, vague prompts like "optimise the code to make it cleaner" will cause timeouts, and may lead to unexpected behaviour.

> (2) For the most insight about what the model is doing as it runs, set the reasoning depth to maximum

This is helpful because it makes the model verbose so it fully describes what it is doing, and forces it to reason more fully and check its implementation. 

<div class="row mt-3">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/claude-reasoning.png" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    The reasoning depth option in VSCode.
</div>

> (3) For the most oversight about what the model is doing as it runs, make sure auto-approvals are turned off

This will mean approval is requested before any code changes are kept or commands run, so you remain in control of the process. With time you may become more confident about the agent's ability to code unsupervised, but frequent git commits so you have the option to roll back changes are probably not a bad idea.

> (4) Using the agent to write code you definitely can't write yourself isn't a good idea in general

This one is a bit context-dependent. I think if all you care about is a final product (like in this case, I wasn't aiming to learn to be a web developer), then asking `Claude` to write code you don't understand is probably fine. Also this project was low-stakes, if it didn't work out then I'd fall back on my `Google sites` old website version, so failure didn't matter. 

But if you're attempting to use an AI agent to write complicated code for a physics project, where interpretation and intimate knowledge of the inner code workings is crucial, then I'd humbly suggest that if you yourself couldn't write the code `Claude` spits out at you, it's of no use to you.

Happy vibe-coding!