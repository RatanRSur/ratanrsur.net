import Script from "next/script";

function CenteredContentBox(props: { children: JSX.Element }) {
  return <div className="centered-window">{props.children}</div>;
}

export default function Home() {
  return (
    <main className="">
      <CenteredContentBox>
        <>
          <img src="/flower.svg" className="flower" />
          <div>
            <p>rai</p>
            <br />
            <br />
            <p>
              <a href="/about">about</a>
            </p>
            <br />
            <p>
              <a href="/content">content</a>
            </p>
            <br />
            <p>
              <a href="/bet">bet</a>
            </p>
            <br />
            <p>
              <a href="/newsletter">newsletter</a>
            </p>
            <br />
            <p>
              <u>
                <a href="/contact">contact</a>
              </u>
            </p>
          </div>
        </>
      </CenteredContentBox>
    </main>
  );
}
